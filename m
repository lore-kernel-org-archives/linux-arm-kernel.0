From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Sep 2013 09:29:26 +0100
Subject: [PATCH] ARM: STi: Add cpu hotplug support
In-Reply-To: <1379924530-26319-1-git-send-email-srinivas.kandagatla@st.com>
References: <1379924530-26319-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20130923082926.GR12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 09:22:10AM +0100, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch adds cpu hotplug support to STi series SoCs. This code is
> cloned from arch/arm/mach-realview/hotplug.c.
> 
> STiH415 and STiH416 SOCs do not have power control lines wired up to
> each core, so all we can do is to put the core into WFI for hotplug
> support.

Note that this means you can't support KEXEC on this platform.
