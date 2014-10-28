From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Oct 2014 14:00:22 +0000
Subject: [PATCH v2 3/5] ARM: restrict CPU_BIG_ENDIAN configuration option
In-Reply-To: <1414503095-25986-4-git-send-email-kaixu.xia@linaro.org>
References: <1414503095-25986-1-git-send-email-kaixu.xia@linaro.org>
 <1414503095-25986-4-git-send-email-kaixu.xia@linaro.org>
Message-ID: <20141028140021.GD27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 09:31:33PM +0800, Xia Kaixu wrote:
> Some platforms don't work when CPU_BIG_ENDIAN is enabled.
> So It can get a dependency on !ARCH_MULTIPLATFORM_STRICT.

What if big endian wants to build a multiplatform kernel?

This doesn't look right to me.  Instead, we should be arranging for
those which do not work in BE mode to depend on !CPU_BIG_ENDIAN.
Yes, it's a larger patch but IMHO is a much more correct solution.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
