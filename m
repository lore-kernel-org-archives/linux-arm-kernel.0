From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 Jan 2013 22:34:25 -0800
Subject: [PATCH v2 1/2] i2c-core: dt: Pick i2c bus number from i2c alias
 if present
In-Reply-To: <1358189602-24180-2-git-send-email-dianders@chromium.org>
References: <1357927027-4857-2-git-send-email-dianders@chromium.org>
 <1358189602-24180-1-git-send-email-dianders@chromium.org>
 <1358189602-24180-2-git-send-email-dianders@chromium.org>
Message-ID: <20130115063425.GE20105@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 10:53:21AM -0800, Doug Anderson wrote:
> This allows you to get the equivalent functionality of
> i2c_add_numbered_adapter() with all data in the device tree and no
> special case code in your driver.  This is a common device tree
> technique.
> 
> For quick reference, the FDT syntax for using an alias to provide an
> ID looks like:
>   aliases {
>     i2c0 = &i2c_0;
>     i2c1 = &i2c_1;
>   };
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

The call path for i2c_add_numbered_adapter() with nr == -1 is a little
awkward now, but I don't see much how it can be improved much.

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
