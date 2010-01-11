From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 23:37:20 +0000
Subject: [RFC 05/18] arm: msm: implement ioremap_strongly_ordered
In-Reply-To: <1263250057-26692-6-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-6-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100111233720.GK7925@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 02:47:24PM -0800, Daniel Walker wrote:
> From: Larry Bassel <lbassel@quicinc.com>
> 
> Both the clean and invalidate functionality needed
> for the video encoder and 7x27 barrier code
> need to have a strongly ordered mapping set up
> so that one may perform a write to strongly ordered
> memory. The generic ARM code does not provide this.
> 
> The generic ARM code does provide MT_DEVICE, which starts
> as strongly ordered, but the code later turns the buffered flag
> on for ARMv6 in order to make the device shared. This is not
> suitable for my purpose, so this patch adds code for a
> MT_DEVICE_STRONGLY_ORDERED mapping type.

This doesn't really describe what "my purpose" is; the patch description
is too vague to ascertain why this is required.
