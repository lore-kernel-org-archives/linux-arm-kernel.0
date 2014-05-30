From: chhotu.shiv@gmail.com (shiv prakash Agarwal)
Date: Sat, 31 May 2014 01:05:29 +0530
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <20140530191852.GA25314@obsidianresearch.com>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <201405061718.54012.arnd@arndb.de>
 <1399389873.29530.3.camel@weser.hi.pengutronix.de>
 <4799695.pjGjqc80tj@wuerfel>
 <CAHH3p5+rNiSLBBeL-coYroa62rxQJ6wjxTdkCcUtXzvvcAQkXQ@mail.gmail.com>
 <5388BE1D.7040504@intel.com>
 <CAHH3p5+cR+AQRjxxA=AZN-P2yNSk9Qb6W0BjhAuFa7WPp38=DQ@mail.gmail.com>
 <20140530191852.GA25314@obsidianresearch.com>
Message-ID: <CAHH3p5KS9BVb-1-u2LbfLL8OO4pmExGmCtZY=fEYELS+q=grcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Jason,

Is there a way to disable sending VDM by Intel card?
And what is the purpose of sending type 1 VDM if it has to be
discarded by root port anyway?

On Sat, May 31, 2014 at 12:48 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Fri, May 30, 2014 at 11:32:34PM +0530, shiv prakash Agarwal wrote:
>> Finally we see that this hang occurs because some VDM is sent by
>> this I210 card.  Why this card sends VDM? and how can we disable it?
>
>> VDM = Venodor Defined Message
>
> FWIW, when I last looked at Intel stuff in an analyzer it was sending
> regular VDMs for some purpose.
>
> Type 1 VDMs should not cause any errors, the root port should just
> silently discard them.
>
> If your root port is returning an error completion or otherwise from a
> type 1 VDM then it is broken and the device would be properly
> asserting DLP. Some work around would be required for that kind of HW
> defect :|
>
> I once tracked down a similar bug with VDM handling in a PCI-E
> device..
>
> Jason
