From: robherring2@gmail.com (Rob Herring)
Date: Mon, 23 Feb 2015 10:50:26 -0600
Subject: [PATCHv2 05/15] ARM: mvebu: add stdout-path to all armada-*.dts
In-Reply-To: <54EB4E9B.6010001@free-electrons.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1424451874-25375-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <54EB4E9B.6010001@free-electrons.com>
Message-ID: <CAL_JsqJZJMkH953hq0_sOvEEu9o4pXxs0sdP5=7c2EXXNSyA9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 10:00 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Thomas,
>
> On 20/02/2015 18:04, Thomas Petazzoni wrote:
>> This commit adds the stdout-path property in /chosen for all Armada
>> boards that were not yet carrying this property.
>
> I though the main motivation for using the stdout-path property was
> for removing the earlyprintk in the command line. Arnd told that there
> should be a mean to use stdout-path instead of earlyprintk.
>
> So what about going further and removing "earlyprintk" in the same time?

Not exactly, stdout-path allows for removing "console" from the
command line. earlyprintk is a debug/developer option, so it should
not be in a default command line IMO.

So bootargs should be removed entirely.

Rob
