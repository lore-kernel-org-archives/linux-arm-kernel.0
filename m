From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 18 Aug 2013 08:09:36 +1000
Subject: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
In-Reply-To: <2032060.4bgTKOdEX2@flatron>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <2032060.4bgTKOdEX2@flatron>
Message-ID: <1376777376.25016.11.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-08-17 at 12:50 +0200, Tomasz Figa wrote:
> I wonder how would this handle uniprocessor ARM (pre-v7) cores, for
> which 
> the updated bindings[1] define #address-cells = <0> and so no reg 
> property.
> 
> [1] - http://thread.gmane.org/gmane.linux.ports.arm.kernel/260795

Why did you do that in the binding ? That sounds like looking to create
problems ... 

Traditionally, UP setups just used "0" as the "reg" property on other
architectures, why do differently ?

Ben.
