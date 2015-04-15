From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 15 Apr 2015 13:54:38 +0200
Subject: [PATCH] input: ambakmi: Fix system PM by converting to modern
 callbacks
In-Reply-To: <20150415093245.GV12732@n2100.arm.linux.org.uk>
References: <1429008108-29295-1-git-send-email-ulf.hansson@linaro.org>
 <20150414162210.GA29874@dtor-ws>
 <20150414223029.GU12732@n2100.arm.linux.org.uk>
 <20150414235822.GA22757@dtor-ws>
 <20150415093245.GV12732@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFpgqo-y6OGsuS_zaNMGp8cKNcxOwszWJyuMD4Mrs_omHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>
> Had I not noticed your message, you would have probably ended up removing
> a driver which is very much in use, is functional, and therefore is not
> as broken as Ulf claims.

I claimed the system PM needed to be fixed, nothing else. :-)

>
> The other lesson to come away from this is that just because someone claims
> something is broken does *not* make it broken.  It means _they_ are seeing
> some problem which maybe no one else is seeing.  Again, that's no basis to
> jump on the "lets remove the whole driver then" bandwagon.
>
> And I doubt that Ulf even has the hardware to be able to test this change,
> which makes it even worse.

Correct, this patch is only compile time tested.

Actually I found it when I just realized that commit 26825cfd90f9
("ARM: 7914/1: amba: Drop legacy PM support and use the pm_generic
functions"), missed to remove the legacy system PM callbacks from the
struct amba_driver, as it should have.

I intended to send a patch for the above when I found these legacy
callbacks still being used. Somehow I missed this once when removing
the legacy system PM support in the amba bus. Sorry about that.

Kind regards
Uffe
