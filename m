From: olof@lixom.net (Olof Johansson)
Date: Tue, 28 Jul 2015 13:56:06 +0200
Subject: [PATCH v3] ARM: appropriate __init annotation for const data
In-Reply-To: <alpine.LFD.2.20.1507271750160.1806@knanqh.ubzr>
References: <alpine.LFD.2.20.1507271750160.1806@knanqh.ubzr>
Message-ID: <20150728115606.GA21866@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 06:27:52PM -0400, Nicolas Pitre wrote:
> 
> Init data marked const should be annotated with __initconst for
> correctness and not __initdata.  In some cases the array gathering
> references to that data has to be marked const as well. This fixes
> LTO builds that otherwise fail with section mismatch errors.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

This passed through the builder here as well. I've applied it to
next/cleanup for 4.3. Thanks!


-Olof
