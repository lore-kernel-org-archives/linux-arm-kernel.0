From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 10 May 2018 15:26:26 +0100
Subject: [PATCH v6 06/11] firmware: xilinx: Add debugfs interface
In-Reply-To: <1523389127-14243-7-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-7-git-send-email-jollys@xilinx.com>
Message-ID: <b880a598-54cb-6428-e60d-232615e809c1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/04/18 20:38, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Firmware-debug provides debugfs interface to all APIs.
> Debugfs can be used to call firmware APIs with required
> parameters.
> 
> Usage:
> * Calling firmware API through debugfs:
>   # echo "<api-name> <arg1> .. <argn>" > /sys/.../zynqmp-firmware/pm
> 
> * Read output of last called firmware API:
>   # cat /sys/.../zynqmp-firmware/pm
> 
> Refer ug1200 for more information on these APIs:
>   * https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf
> 
> Add basic debugfs file to get API version.
Who are the users of this apart from debugging ? I am bit over sensitive
as this remote processor manages/controls the power and other shared
resources in the system. Giving such fine grained access to user space
is not a good idea. I assume you want this DEBUGFS off by default on
production images ?

-- 
Regards,
Sudeep
