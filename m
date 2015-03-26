From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Mar 2015 11:49:55 +0000
Subject: [PATCH v7 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <5513F0D9.5080807@arm.com>
References: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
 <1425466884-30648-1-git-send-email-vincent.yang@socionext.com>
 <5513F0D9.5080807@arm.com>
Message-ID: <20150326114955.GE8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 11:43:21AM +0000, Sudeep Holla wrote:
> I tried using this driver and found that AMBA driver expects apb_clk
> without which probe fails. Though your example have it, it's not
> explicit from the binding. Also AMBA binding expects the primecell id in
> the binding.

That's optional:

Optional properties:

- arm,primecell-periphid : Value to override the h/w value with

It's only required when the hardware doesn't provide the correct value.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
