From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Sat, 23 Apr 2011 14:33:21 +0200
Subject: [PATCH] drivers: brcmaxi: provide amba axi functionality in
	separate module
In-Reply-To: <op.vuallvn63ri7v4@arend-laptop>
References: <1303331669-31293-1-git-send-email-arend@broadcom.com>
	<201104211612.49805.arnd@arndb.de> <op.vuallvn63ri7v4@arend-laptop>
Message-ID: <BANLkTinUWNvkigqkOQeYsyaAKnVXOCji8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 April 2011 16:38, Arend van Spriel <arend@broadcom.com> wrote:
> Would it be possible to make chipcommon driver optional (not doing the
> initialization)?

This would need to be done on a per-device/bus basis, at least for
embedded. Consider the following setup (which is quite common for dual
band routers):

BCM4718
+- Common Core <- provides flash write access, GPIOs, watchdog, ...
+- 802.11 Core <- for 2.4Ghz wifi
+- PCIe Core
  + BCM43224
    +- Common Core
    +- 802.11 Core <- for 5Ghz wifi

(I omitted any cores not relevant for the example)

So eventually you want to able to drive both 802.11 cores, but can't
exclusively claim both common cores.

Regards
Jonas
