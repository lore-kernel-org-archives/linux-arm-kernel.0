From: pcc@google.com (Peter Collingbourne)
Date: Fri, 9 Nov 2018 10:09:55 -0800
Subject: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
In-Reply-To: <20181109123730.8743-8-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
Message-ID: <CAMn1gO5tmJDXEgAZefcOmp1E2LmG3uqbO7vFwZRxAy2Cny114g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 9, 2018 at 4:38 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> -ccflags-y := -shared -fno-common -fno-builtin
> +ccflags-y := -shared -fno-common -fno-builtin -fno-stack-protector

This either needs to include -ffixed-x18 or
https://patchwork.kernel.org/patch/10671685/ needs to appear earlier
in this series.

Peter
