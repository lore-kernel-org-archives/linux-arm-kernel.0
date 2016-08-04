From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 4 Aug 2016 18:16:41 +0530
Subject: [PATCH 10/10] dmaengine: qcom_hidma: add MSI support for
 interrupts
In-Reply-To: <e6560c8b-e18e-9e32-5b51-c1c12d8551ce@codeaurora.org>
References: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
 <1468867177-15007-11-git-send-email-okaya@codeaurora.org>
 <20160724064256.GA9681@localhost>
 <e6560c8b-e18e-9e32-5b51-c1c12d8551ce@codeaurora.org>
Message-ID: <20160804124641.GE9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 24, 2016 at 10:38:11AM -0400, Sinan Kaya wrote:
> >> +       if (rc)
> >> +               dev_warn(&pdev->dev,
> >> +                        "failed to request MSI irq, falling back to wired IRQ\n");
> >> +       return rc;
> >> +#else
> >> +       return -EINVAL;
> > 
> > -EINVAL doesnt sound apt here..
> 
> What should I use? -ENOENT ?

that sounds okay or EIO

> >> +                       return false;
> >> +
> >> +               ret = strcmp(of_compat, "qcom,hidma-1.1");
> >> +       } else {
> >> +               ret = strcmp(acpi_device_hid(adev), "QCOM8062");
> > 
> > Okay if you ahve a device ID then why do we need new binding? This device as
> > you said implies the support for MSI interrupts.
> 
> 
> Yes, I do have a new device ID for platforms with MSI capability. 
> 
> Which new binding are you referring to?

If you have "QCOM8062" why do you need DT to tell hidma-1.1 ?

-- 
~Vinod
