From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Feb 2014 17:53:43 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4
In-Reply-To: <1391612769-27890-1-git-send-email-illia.smyrnov@globallogic.com>
References: <1391612769-27890-1-git-send-email-illia.smyrnov@globallogic.com>
Message-ID: <alpine.DEB.2.02.1402191752590.8777@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Feb 2014, Illia Smyrnov wrote:

> Commit 313a76e (ARM: OMAP2+: hwmod: Fix SOFTRESET logic) introduced
> softreset bit cleaning right after set one. It is caused L3 error for
> OMAP4 ISS because ISS register write occurs when ISS reset process is in
> progress. Avoid this situation by cleaning softreset bit later, when reset
> process is successfully finished.
> 
> Signed-off-by: Illia Smyrnov <illia.smyrnov@globallogic.com>

Thanks, queued for v3.14-rc with notations from Grygorii and Roger.


- Paul
