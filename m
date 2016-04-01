From: tj@kernel.org (Tejun Heo)
Date: Fri, 1 Apr 2016 10:44:06 -0400
Subject: [PATCH v3 0/3] ahci: add ports-implemented dt bindings
In-Reply-To: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160401144406.GS7822@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 08:52:55AM +0100, Srinivas Kandagatla wrote:
> On some SOCs PORTS_IMPL register value is never programmed by the BIOS
> and left at zero value. Which means that no sata ports are available for
> software. AHCI driver used to cope up with this by fabricating the
> port_map if the PORTS_IMPL register is read zero, but recent patch [1]
> broke this workaround as zero value was valid for nvme disks.
> 
> This patch adds ports-implemented dt bindings as workaround for this issue
> in a way that DT can dictate the port_map incase where the SOCs does not
> program it already.

Applied all three patches to libata/for-4.6-fixes w/ stable cc'd.

Thanks.

-- 
tejun
