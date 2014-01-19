From: tj@kernel.org (Tejun Heo)
Date: Sun, 19 Jan 2014 14:17:06 -0500
Subject: [RFC v3 05/13] ahci-platform: Pass ahci_host_priv ptr to
 ahci_platform_data init method
In-Reply-To: <52DC1EC4.3090807@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-6-git-send-email-hdegoede@redhat.com>
 <20140119113051.GD11123@htj.dyndns.org>
 <52DC1EC4.3090807@redhat.com>
Message-ID: <20140119191706.GC32165@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:51:48PM +0100, Hans de Goede wrote:
> Yes, but they are part of arch/arm/mach-foo, so moving them is non trivial, and
> I don't want to go make these kinda changes without hardware to test. Please keep
> in mind that I'm partially cleaning up other peoples mess here (the imx bits
> specifically). I'm willing to do that to some extend (*). But buying an imx6q board
> and fixing that is about as far as I'm willing to go.

If they can't be moved, the right thing to do is moving the header out
to include/linux so that they can be included from those directories.
Let's please not contort the API to fit the organizational issues.

Thanks.

-- 
tejun
