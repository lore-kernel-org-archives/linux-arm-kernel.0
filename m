From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 May 2012 13:19:41 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <4FA90BE1.3050304@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FA90BE1.3050304@linaro.org>
Message-ID: <20120508121940.GL15893@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 01:04:49PM +0100, Lee Jones wrote:
> On 07/05/12 18:08, Mark Brown wrote:

> >You should be using of_regulator_match() for this (I think it's supposed
> >to do an equivalent job...) rather than open coding.

> of_regulator_match() didn't exist when I wrote this. In fact, it
> only made it into -next a couple of days ago. Besides, it doesn't

It's been kicking around for review for a little while longer than that
(it was waiting for review while Rhyland was on holiday), and in any
case half the reason for adding infrastructure is to avoid adding
repeated code.

> satisfy the needs of this code segment. of_regulator_match() is
> a(nother) wrapper around of_get_regulation_constraints(), which is
> only used to populate 'struct regulation_constraints constraints'
> after being provided with a selection of .compatible strings.

I suspect that what you're trying to achieve isn't a good regulator
binding but I'm not entirely sure what you're trying to do so perhaps
not.  You haven't documented the binding at all which might make things
clearer...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120508/5436d4b0/attachment-0001.sig>
