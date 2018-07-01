From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 1 Jul 2018 20:32:49 -0300
Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
In-Reply-To: <20180701093402.GN4348@dragon>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
 <20180701093402.GN4348@dragon>
Message-ID: <CAOMZO5BjOEGWv2dC-bp0BYHq+PhLssEKic+o7ock8_1Dobd=sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 1, 2018 at 6:34 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Mon, Jun 25, 2018 at 08:34:11PM +0800, Robin Gong wrote:
>> SW4 is one power rail for LPDDR2 on i.mx6sl-evk, so it should
>> be kept always on. But it's disabled after switch disabled
>> interface implemented in pfuze driver
>> 'commit 5fe156f1cab4
>> ("regulator: pfuze100: add enable/disable for switch")'.Thus,
>> it breaks kernel bootup. Add 'regulator-always-on' for SW4.
>>
>> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
>
> Does that mean boards with existing DTB installed will stop working with
> new kernel?  That's bad, and the kernel commit should probably be
> reverted.

Yes, this is a good point.

Anson,

Should 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for
switch") be reverted to avoid such breakage?
