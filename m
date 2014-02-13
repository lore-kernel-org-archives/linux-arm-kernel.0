From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 13 Feb 2014 09:28:52 +0100
Subject: [PATCH] ARM: tegra: don't timeout if CPU is powergated
In-Reply-To: <52FBC97D.8040809@wwwdotorg.org>
References: <1d5ea6b7df4573d866779857922ac650fe59af60.1392078805.git.stefan@agner.ch>
 <52FBC97D.8040809@wwwdotorg.org>
Message-ID: <4050206.sG2EzXyfMN@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 12. Februar 2014, 12:20:29 schrieb Stephen Warren:
> On 02/10/2014 05:44 PM, Stefan Agner wrote:
> > When booting secondary CPU(s) which are not yet powergated, a wrong
> > check lead to a timeout after 100 jiffies. With this patch, we only
> > delay powergating if CPUs are still not powered yet.
> 
> I've applied this to Tegra's for-3.15/soc branch.

also for 3.14 and maybe lower versioned kernels? Since this seems to fix a bug 
where some core doesn't come up.

Marc
