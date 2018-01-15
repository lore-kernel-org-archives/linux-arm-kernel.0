From: moore@free.fr (Chris Moore)
Date: Mon, 15 Jan 2018 06:53:48 +0100
Subject: [PATCH v2 1/3] crypto/generic: sha3 - fixes for alignment and big
 endian operation
In-Reply-To: <20180114164118.18330-2-ard.biesheuvel@linaro.org>
References: <20180114164118.18330-1-ard.biesheuvel@linaro.org>
 <20180114164118.18330-2-ard.biesheuvel@linaro.org>
Message-ID: <cad7b34c-ca50-f856-c3fa-221b4c937d3e@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 14/01/2018 ? 17:41, Ard Biesheuvel a ?crit?:
> Ensure that the input is byte swabbed before injecting it into the

Nitpick : s/swabbed/swapped/

> SHA3 transform. Use the get_unaligned() accessor for this so that
> we don't perform unaligned access inadvertently on architectures
> that do not support that.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Cheers,
Chris
