From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 16 May 2013 11:38:49 +0200
Subject: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
In-Reply-To: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130516093846.GA2927@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 10:50:07AM +0800, Barry Song wrote:
> From: Xiaomeng Hou <Xiaomeng.Hou@csr.com>
> 
> if we initilize i2c bus by module_init, there are some devices which want
> initialization earlier than i2c and could not do that in time, so move i2c
> driver initilization to subsys_initcall and make i2c ready before devices
> init.
> 
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

What about deferred probing?
