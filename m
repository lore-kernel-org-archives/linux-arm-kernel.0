From: tj@kernel.org (Tejun Heo)
Date: Sun, 19 Jan 2014 14:15:54 -0500
Subject: [RFC v3 03/13] ahci-platform: Fix clk enable/disable unbalance
 on suspend/resume
In-Reply-To: <52DC1DAA.3010403@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-4-git-send-email-hdegoede@redhat.com>
 <20140119111412.GA11123@htj.dyndns.org>
 <52DC1DAA.3010403@redhat.com>
Message-ID: <20140119191554.GB32165@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On Sun, Jan 19, 2014 at 07:47:06PM +0100, Hans de Goede wrote:
> As I see it either doing clks, regulator and sata-core things in a common
> place makes sense, and then it goes for suspend and resume too, or we
> opt for always following the complete override model, and which point
> it becomes more sensible to just do a separate platform driver per
> ahci implementation.

It makes sense in light of those specific cases, but there are gonna
be cases where the placement of the callback is slightly wrong and we
end up with ->XXX_ops_pre() and then ->XXX_ops_post() and so on.
Please make the whole op overridable and then export the default op
and use it as library.

Thanks.

-- 
tejun
