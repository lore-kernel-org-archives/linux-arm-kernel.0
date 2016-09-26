From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2016 16:19:31 +0100
Subject: [PATCH v2] ARM/dt: Respect property size when parsing CPUs
In-Reply-To: <7955b34dcafcc20829c0521c0a0371c27d102f1f.1474898916.git.robin.murphy@arm.com>
References: <31c4684aa8ef7ef210cc74da5f1b02ff2882a099.1474645829.git.robin.murphy@arm.com>
 <7955b34dcafcc20829c0521c0a0371c27d102f1f.1474898916.git.robin.murphy@arm.com>
Message-ID: <20160926151931.GG1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2016 at 03:25:24PM +0100, Robin Murphy wrote:
> Whilst MPIDR values themselves are less than 32 bits, it is still
> perfectly valid for a DT to have #address-cells > 1 in the CPUs node,
> resulting in the "reg" property having leading zero cell(s). In that
> situation, the big-endian nature of the data conspires with the current
> behaviour of only reading the first cell to cause the kernel to think
> all CPUs have ID 0, and become resoundingly unhappy as a consequence.
> 
> Take the full property length into account when parsing CPUs so as to
> be correct under any circumstances.

Please drop this into the patch system, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
