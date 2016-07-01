From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Fri, 1 Jul 2016 08:34:21 +0200
Subject: [PATCH v2 06/14] ARM: sun8i: clk: Add clk-factor rate application
 method
In-Reply-To: <20160701073710.1a1fc684ae448577bad5b0db@free.fr>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-7-megous@megous.com> <20160630204001.GC5485@lukather>
 <0b71ed7e-98c9-109e-85e6-ceb95131d88a@megous.com>
 <20160701073710.1a1fc684ae448577bad5b0db@free.fr>
Message-ID: <643c2648-ddd6-700a-68c0-2981134965c0@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1.7.2016 07:37, Jean-Francois Moine wrote:
> On Fri, 1 Jul 2016 02:50:57 +0200
> Ond?ej Jirman <megous@megous.com> wrote:
> 
>>> Since this is really specific, I guess you could simply make the
>>> clk_ops for the nkmp clocks public, and just re-implement set_rate
>>> using that logic.
>>
>> I would argue that this may be necessary for other PLL clocks too, if
>> you can get out of bounds output frequency, by changing the dividers too
>> early or too late. So perhaps this code should be generalized for other
>> PLL clocks too, instead.
> 
> The documentation says that only the CPU and DDR PLLs can be dynamically
> changed after boot.

The question is what exactly is meant by after boot. :) Anyway, if the
kernel has no business changing some other PLLs, if there's code for
changing them, should it be dropped?

regards,
  Ondrej

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160701/729f1527/attachment.sig>
