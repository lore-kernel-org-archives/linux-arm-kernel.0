From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 26 Jul 2016 14:56:44 -0700
Subject: [PATCH] pinctrl: meson: Drop pinctrl_unregister for devm_
 registered device
In-Reply-To: <20160726170053.GA40841@dtor-ws> (Dmitry Torokhov's message of
 "Tue, 26 Jul 2016 10:00:53 -0700")
References: <1469544718-32001-1-git-send-email-weiyj.lk@gmail.com>
 <20160726170053.GA40841@dtor-ws>
Message-ID: <m2a8h4ukpv.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Tue, Jul 26, 2016 at 02:51:58PM +0000, Wei Yongjun wrote:
>> It's not necessary to unregister pin controller device registered
>> with devm_pinctrl_register() and using pinctrl_unregister() leads
>> to a double free.
>> 
>> This is detected by Coccinelle semantic patch.
>> 
>> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
>
> Fixes: e649f7ec8c5f ("pinctrl: meson: Use devm_pinctrl_register() for
> pinctrl registration")
>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
