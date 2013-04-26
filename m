From: robherring2@gmail.com (Rob Herring)
Date: Thu, 25 Apr 2013 21:51:10 -0500
Subject: [RFC PATCH v3 02/17] Documentation: devicetree: arm: cpus/cpu
 nodes bindings updates
In-Reply-To: <1366824502-19729-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366824502-19729-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <CAL_JsqL2QOjTffogB6g7VK7oRUwDAmJpr=36uvFXjd+hpBL89A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 12:28 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> In order to extend the current cpu nodes bindings to newer CPUs
> inclusive of AArch64 and to update support for older ARM CPUs this
> patch updates device tree documentation for the cpu nodes bindings.
>
> Main changes:
>     - adds 64-bit bindings
>     - define usage of #address-cells
>     - define 32/64 dts compatibility settings
>     - defines behaviour on pre and post v7 uniprocessor systems
>     - adds ARM 11MPcore specific reg property definition
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---

[...]

> +       - enable-method
> +               Value type: <stringlist>
> +               Usage and definition depend on ARM architecture version and
> +               configuration:
> +                       # On ARM v8 64-bit systems running the OS in AArch64,
> +                         this property is required and must be "spin-table".

What about PSCI?

I don't think the ePAPR spin-table definition is sufficient for ARM.
How do you define wake up by SGI or sev instruction.

> +                       # On ARM 32-bit systems or ARM v8 systems running
> +                         the OS in AArch32 this property is prohibited.

Why?

Rob
