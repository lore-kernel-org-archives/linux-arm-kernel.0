From: olof@lixom.net (Olof Johansson)
Date: Sun, 14 Sep 2014 23:16:32 -0700
Subject: [PATCH v4 01/18] ARM64: Move the init of cpu_logical_map(0)
 before unflatten_device_tree()
In-Reply-To: <1410530416-30200-2-git-send-email-hanjun.guo@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-2-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140915061632.GA26649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 09:59:59PM +0800, Hanjun Guo wrote:
> It always make sense to initialize CPU0's logical map entry from the
> hardware values, so move the initialization of cpu_logical_map(0)
> before unflatten_device_tree() which is needed by ACPI code later.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Olof Johansson <olof@lixom.net>

With or without needs for ACPI, I don't think there's any reason for
this code to not go in now.


-Olof
