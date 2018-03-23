From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 22 Mar 2018 19:23:07 -0500
Subject: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
In-Reply-To: <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
 <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
Message-ID: <b5dac2f7-eabb-6e09-2146-775b09d4eca8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2018 07:16 PM, Timur Tabi wrote:
> 
> This needs to be ret <= max_gpios, otherwise it will fail if every GPIO 
> is available.
> 
> And it should print an error message and return an error code if ret > 
> max_gpios.

Also, you don't allocate chip->valid_mask anywhere.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
