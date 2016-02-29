From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Mon, 29 Feb 2016 11:12:36 +0100
Subject: [PATCH v12 4/5] arm64, numa: Add NUMA support for arm64 platforms.
In-Reply-To: <CAFpQJXURSKFw6RmNVLiB=YDcUiaaQLz3zMvM9gy=b1MobaCfgg@mail.gmail.com>
References: <1456192703-2274-1-git-send-email-ddaney.cavm@gmail.com>
 <1456192703-2274-5-git-send-email-ddaney.cavm@gmail.com>
 <20160226185341.GN29125@arm.com>
 <56D0ACC4.1060605@caviumnetworks.com>
 <CAFpQJXURSKFw6RmNVLiB=YDcUiaaQLz3zMvM9gy=b1MobaCfgg@mail.gmail.com>
Message-ID: <20160229101236.GQ24726@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.02.16 09:43:49, Ganapatrao Kulkarni wrote:
> On Sat, Feb 27, 2016 at 1:21 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> > On 02/26/2016 10:53 AM, Will Deacon wrote:

> >>> +static __init int numa_parse_early_param(char *opt)
> >>> +{
> >>> +       if (!opt)
> >>> +               return -EINVAL;
> >>> +       if (!strncmp(opt, "off", 3)) {
> >>> +               pr_info("%s\n", "NUMA turned off");
> >>> +               numa_off = 1;
> >>> +       }
> >>> +       return 0;
> >>> +}
> >>> +early_param("numa", numa_parse_early_param);
> >>
> >>
> >> Curious, but when is this option actually useful?
> >>
> >
> > Good point.  I will remove that bit, it was used as an aid in debugging
> > while bringing up the patch set.
> 
> this is handy in debugging new platforms.
> this boot argument option forces to boot as single node dummy system
> adding all resources to node0.

This is used to disable numa in a numa enabled kernel esp. for
debugging/enabling/booting single node systems. Same kernel parameter
as for x86 and other archs. Should not being removed.

-Robert
