From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 24 Mar 2018 00:02:24 -0400
Subject: [PATCH v6 6/6] bnxt_en: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <CACKFLinCMQ6aFXJDcqkTGGuPSEWsPPB09sS=mJJgsCdm5mvjhA@mail.gmail.com>
References: <1521843791-21201-1-git-send-email-okaya@codeaurora.org>
 <1521843791-21201-7-git-send-email-okaya@codeaurora.org>
 <CACKFLinCMQ6aFXJDcqkTGGuPSEWsPPB09sS=mJJgsCdm5mvjhA@mail.gmail.com>
Message-ID: <9a5f49c8-ce50-a153-44e1-6f21f8d1f44b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/23/2018 6:36 PM, Michael Chan wrote:
>> +               mmiowb();
> Sorry for the late review.  mmiowb() is not required here because we
> are in NAPI context, so only one CPU will be updating this doorbell.
> 
> Other than that, it looks good.
> 

OK, I'll fix this on the next version.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
