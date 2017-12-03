From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sat, 2 Dec 2017 20:00:57 -0800
Subject: [PATCH v6 0/2] memory: Introduce ti-emif-sram driver
In-Reply-To: <1512082568-5012-1-git-send-email-d-gerlach@ti.com>
References: <1512082568-5012-1-git-send-email-d-gerlach@ti.com>
Message-ID: <179c7668-05eb-09cf-9857-7b6fd2308c3a@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/30/17 2:56 PM, Dave Gerlach wrote:
> This is a resend of v5 of this series found here [1]. It introduces
> relocatable PM handlers for the emif that are copied to sram and
> run from there during low power mode entry.
> 
> The patches still have the previous ACKs but have a small change to
> accomodate a change made by Tony in commit cd57dc5a2099 ("ARM: dts:
> Add missing hwmod related nodes for am33xx"). If there are objections
> to this let me know ASAP.
> 
> Now that a hwmod is present for the am335x EMIF, on probe fail the call to
> pm_runtime_put_sync causes the board to hang. In fact, this emif driver should
> never alter the PM state of the hardware at all through normal kernel calls, it
> is the job of the suspend handlers that are added, that is the whole point of
> this driver. Because of this, I have dropped all runtime pm calls, as any
> change to the PM state while the kernel is running is dangerous as we may shut
> of the memory controller. It makes the most sense just to drop runtime PM from
> the driver entirely. Besides that patch is unchanged.
> 
> This code is required for low-power modes to work on AM335x and AM437x and a
> forthcoming PM series for those platforms will depend on this series. After
> both this and the PM series are reviewed I will send the necessary device tree
> changes for both, but in the meantime all remaining patches for am335x and
> am437x PM can be found here [2].
> 
Applied
