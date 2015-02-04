From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Feb 2015 00:14:39 +0000
Subject: [Linaro-mm-sig] [RFCv3 2/2] dma-buf: add helpers for sharing
 attacher constraints with dma-parms
In-Reply-To: <3327782.QV7DJfvifL@wuerfel>
References: <1422347154-15258-1-git-send-email-sumit.semwal@linaro.org>
 <7233574.nKiRa7HnXU@wuerfel>
 <20150203200435.GX14009@phenom.ffwll.local>
 <3327782.QV7DJfvifL@wuerfel>
Message-ID: <20150204001439.GB8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 10:42:26PM +0100, Arnd Bergmann wrote:
> Right, if you have a private iommu, there is no problem. The tricky part
> is using a single driver for the system-level translation and the gpu
> private mappings when there is only one type of iommu in the system.

You've got a problem anyway with this approach.  If you look at my
figure 2 and apply it to this scenario, you have two MMUs stacked
on top of each other.  That's something that (afaik) we don't support,
but it's entirely possible that will come along with ARM64.

It may not be nice to have to treat GPUs specially, but I think we
really do need to, and forget the idea that the GPU's IOMMU (as
opposed to a system MMU) should appear in a generic form in DT.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
