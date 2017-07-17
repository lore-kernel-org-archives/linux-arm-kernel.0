From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 17 Jul 2017 17:46:24 +0800
Subject: [PATCH] pinctrl: zte: fix 'functions' allocation in
 zx_pinctrl_build_state()
In-Reply-To: <20170717080221.gqf7xgeo2zqgigdq@mwanda>
References: <1500212008-29321-1-git-send-email-shawnguo@kernel.org>
 <20170717080221.gqf7xgeo2zqgigdq@mwanda>
Message-ID: <20170717094622.GE3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 11:02:21AM +0300, Dan Carpenter wrote:
> Shouldn't there be a free if the remove function?  I'm not even sure
> where the remove function is so I don't know.

As the pinctrl driver is essential for the platform, it's always a
builtin_platform_driver which we do not even have a remove function.

Shawn
