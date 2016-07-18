From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 18 Jul 2016 17:23:21 -0400
Subject: [PATCH V9 4/9] vfio: platform: add support for ACPI probe
In-Reply-To: <20160718113208.5afb26c2@t450s.home>
References: <1468461995-32676-1-git-send-email-okaya@codeaurora.org>
 <1468461995-32676-5-git-send-email-okaya@codeaurora.org>
 <20160714154146.38e37d84@t450s.home>
 <bd8dacde-da6c-2353-7488-58b2f050699c@codeaurora.org>
 <20160718113208.5afb26c2@t450s.home>
Message-ID: <83c60af8-ad2a-d351-eace-82e653183521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/18/2016 1:32 PM, Alex Williamson wrote:
> The implementation looks pretty fixed, it seems like a lot would break
> if that were changed, so the callers of the function would need to be
> updated, including this one.  The ternary below is already paranoid
> enough to handle an API change, but if you want to add one more level
> of paranoia, you could use WARN_ON(!vdev->acpihid) to make it user
> visible.  It could still be done as:
> 
> return WARN_ON(!vdev->acpihid) ? -ENOENT : 0;

OK. I'm adding this and will post a new version after testing.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
