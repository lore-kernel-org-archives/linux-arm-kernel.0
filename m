From: ryan@finnie.org (Ryan Finnie)
Date: Tue, 29 May 2018 18:49:38 -0700
Subject: [PATCH V3 1/2] PCI: Try to clean up resources via remove if
 shutdown doesn't exist
In-Reply-To: <1527542471-10316-1-git-send-email-okaya@codeaurora.org>
References: <1527542471-10316-1-git-send-email-okaya@codeaurora.org>
Message-ID: <0bf8bfe6-370d-8794-d205-f3ff51f23f4c@finnie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2018 02:21 PM, Sinan Kaya wrote:
> It is up to a driver to implement shutdown() callback. If shutdown()
> callback is not implemented, PCI device can have pending interrupt and
> even do DMA transactions while the system is going down.
> 
> If kexec is in use, this can damage the newly booting kexec kernel
> or even prevent it from booting altogether. Fallback to calling the
> remove() callback if shutdown() isn't implemented for a given driver.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199779
> Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
> Cc: stable at vger.kernel.org
> Reported-by: Ryan Finnie <ryan@finnie.org>

Tested successfully on DL360 Gen9 and DL380 Gen9.

Tested-by: Ryan Finnie <ryan@finnie.org>
