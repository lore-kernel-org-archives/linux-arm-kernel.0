From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Jun 2013 13:21:35 -0600
Subject: [PATCH v2 2/3] ARM: tegra: split setting of CPU reset handler
In-Reply-To: <1371114745-24710-3-git-send-email-acourbot@nvidia.com>
References: <1371114745-24710-1-git-send-email-acourbot@nvidia.com>
 <1371114745-24710-3-git-send-email-acourbot@nvidia.com>
Message-ID: <51BA1BBF.6050106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2013 03:12 AM, Alexandre Courbot wrote:
> Not all Tegra devices need to set the CPU reset handler in the same way.

s/need/can/ ?

> In particular, devices using a TrustZone secure monitor cannot set the
> reset handler directly and need to do it through a firmware operation.
> 
> This patch separates the act of setting the reset handler from its
> preparation, so the former can be implemented in a different way.
