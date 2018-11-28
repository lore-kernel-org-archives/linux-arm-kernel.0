From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 28 Nov 2018 13:47:27 -0800
Subject: [PATCH v2] soc: bcm: brcmstb: Don't leak device tree node
 reference
In-Reply-To: <20181124145223.29208-1-tiny.windzz@gmail.com>
References: <20181124145223.29208-1-tiny.windzz@gmail.com>
Message-ID: <d9a0cefe-1c8e-2d34-802a-d5f8de01df7b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/24/18 6:52 AM, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node returned by it
> and that reference needs to be dropped by its caller. soc_is_brcmstb()
> doesn't do that, so fix it.
> 
> [treding: slightly rewrite to avoid inline comparison]
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied to drivers/next, thanks!
-- 
Florian
