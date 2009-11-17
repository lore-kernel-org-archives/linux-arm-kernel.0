From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 17 Nov 2009 05:04:57 -0600
Subject: [PATCH 01/02] backlight: control WLED output current in da9034
In-Reply-To: <771cded00911162327i2f0f6b15gf9a7cb7b1391ed74@mail.gmail.com>
References: <771cded00911042357m7785312ewf29e39dd93b6d389@mail.gmail.com>
	<771cded00911050020w3d9ef572h392603dcb9456f96@mail.gmail.com>
	<771cded00911162327i2f0f6b15gf9a7cb7b1391ed74@mail.gmail.com>
Message-ID: <f17812d70911170304p11b73172of0a85dda378e83b3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 1:27 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Thu, Nov 5, 2009 at 3:20 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>> On Thu, Nov 5, 2009 at 2:57 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>>> From ff0d136a181ce431a0db9582f18733425a51411d Mon Sep 17 00:00:00 2001
>>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>>> Date: Thu, 5 Nov 2009 10:27:13 -0500
>>> Subject: [PATCH] backlight: control WLED output current in da9034
>>>
>>> Update WLED output current source before changing brightness.
>>>
>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Haojian,

I've updated the patch as follows, changes:

1. out_current --> output_current
2. output_current will be set only once during probe - we don't need to
adjust it every time backlight is changed, right?
3. and thus removing the out_current field within da903x_backlight_data

Please help review and verify, thanks.
