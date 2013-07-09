From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Jul 2013 09:56:02 +0200
Subject: [PATCH v1 0/4] ARM: STi fixes and ethernet support
In-Reply-To: <51DBB629.1050000@st.com>
References: <1373271301-11060-1-git-send-email-srinivas.kandagatla@st.com>
 <201307090118.06715.arnd@arndb.de> <51DBB629.1050000@st.com>
Message-ID: <201307090956.03191.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 July 2013, Srinivas KANDAGATLA wrote:
> stmmac (aka "dwmac" a synopsis IP) driver is integrated in to kernel
> sometime in 2.6 series I think :-), and Is used by more than 4 platforms
> in 3.10 kernel. The driver is more generic than it sounds.
> So adding properties/hooks specific to STiH41x SOCs in driver seemed to
> incorrect. Instead doing platform specific bits in the mach via
> callbacks was the only choice I had.

No, you should be using generic interfaces to do the things you need.

I believe what you are missing is an ethernet phy driver that is specific
to your SoC.

	Arnd
