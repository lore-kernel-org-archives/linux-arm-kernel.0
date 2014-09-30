From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 30 Sep 2014 07:15:06 -0700
Subject: [RFC 4/7] soc: qcom: Add Shared Memory Manager driver
In-Reply-To: <542A4D80.60101@smartplayin.com>
References: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412037291-16880-5-git-send-email-bjorn.andersson@sonymobile.com>
 <542A4AEF.2030402@smartplayin.com> <542A4D80.60101@smartplayin.com>
Message-ID: <20140930141505.GJ28481@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 29 Sep 23:28 PDT 2014, Kiran Padwal wrote:

> 
> Hi,
> 
> On Tuesday 30 September 2014 11:47 AM, Kiran Padwal wrote:
> > Hi Bjorn,
> > 
> > On Tuesday 30 September 2014 06:04 AM, Bjorn Andersson wrote:
[..]
> >> +	smem->hwlock = of_hwspin_lock_request(pdev->dev.of_node, NULL);
> > 
> > Compilation breaks while I try to compile with this patch.
> > Do I missing anything? Below is the error I am getting,
> > 
> > drivers/soc/qcom/qcom_smem.c: In function ?qcom_smem_probe?:
> > drivers/soc/qcom/qcom_smem.c:274:2: error: implicit declaration of function ?of_hwspin_lock_request? [-Werror=implicit-function-declaration]
> >   smem->hwlock = of_hwspin_lock_request(pdev->dev.of_node, NULL)
> 
> I am sorry I missed the note in commit message of this patch. I did look for any such note in cover letter 
> and also googled around for any change to find this function.
> Could not find and hence posted comment. Please ignore.
> 

I respun this ontop of Suman Anna's latest hwspinlock patches [1] and [2].

The above code should now be:

        hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
	smem->hwlock = hwspin_lock_request_specific(hwlock_id);

Will include this in the next spin.

[1] https://patchwork.kernel.org/patch/4898051/
[2] https://patchwork.kernel.org/patch/4898071/

Regards,
Bjorn
