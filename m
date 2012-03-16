From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 16 Mar 2012 18:29:08 +0100
Subject: [PATCH v5 2/3] arm:davinci: move emif driver to mfd framework
In-Reply-To: <A73F36158E33644199EB82C5EC81C7BC317702E9@DBDE01.ent.ti.com>
References: <y> <1330005504-25321-3-git-send-email-prakash.pm@ti.com>
 <20120227142638.GN27687@sortiz-mobl>
 <A73F36158E33644199EB82C5EC81C7BC3176D103@DBDE01.ent.ti.com>
 <20120301112329.GI9008@sortiz-mobl>
 <A73F36158E33644199EB82C5EC81C7BC317702E9@DBDE01.ent.ti.com>
Message-ID: <20120316172908.GG20524@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prakash,

On Tue, Mar 06, 2012 at 01:12:25PM +0000, Manjunathappa, Prakash wrote:
> Hi Samuel,
> 
> May be I did not do a good job giving complete information on this earlier.
> So I have replied on top of my mail with below information (seems you missed it)
> 
I did get it, sorry for not being able to reply earlier.


> Taking above points into consideration Arnd Bergmann suggested to move AEMIF driver to
> MFD framework [1], relevant portion of his mail as follows,
> 
> " If you want it to provide endpoint devices that are handled by
> distinct subsystems in Linux, I would make it an mfd multifunction
> device and make the common... "
You're missing that part of the quote:

"...code a driver that scans the connected memories in order to register
its child devices for each of the subsystems."

If you can do that, then I'd take that patch to the MFD subsystem. Otherwise,
the only incentive for me to take it would be to be able to share the 2
functions currently in this driver between several archs. But MFD would just
be a placeholder for this driver right now.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
