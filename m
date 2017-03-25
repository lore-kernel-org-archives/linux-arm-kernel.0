From: balbi@kernel.org (Felipe Balbi)
Date: Sat, 25 Mar 2017 09:52:29 +0200
Subject: [PATCH 1/7] usb: dwc3: core: fix dwc3_probe() to not do put_sync
 when get_sync fails
In-Reply-To: <2238ea52423a83118ab724a96e8f0691ec4ada0b.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
 <2238ea52423a83118ab724a96e8f0691ec4ada0b.1490387086.git.shuahkh@osg.samsung.com>
Message-ID: <87mvc923pe.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Shuah Khan <shuahkh@osg.samsung.com> writes:
> dwc3_probe() does pm_runtime_put_sync() in its err1 handling when
> pm_runtime_get_sync() fails.  Move the pm_runtime_put_sync() under
> err2 instead as it is used in error paths after pm_runtime_get_sync()
> succeeds.

there's nothing wrong with current code. Read the docs. Even if
pm_runtime_get*() fails, you still need to decrement the usage
counter. pm_runtime_put*() is one way of achieving so.

-- 
balbi
