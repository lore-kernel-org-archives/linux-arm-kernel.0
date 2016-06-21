From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jun 2016 17:31:13 +0200
Subject: [PATCH 2/2] bus: mvebu-mbus: make mvebu_mbus_syscore_ops static
In-Reply-To: <1466522179-22198-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1466522179-22198-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466522179-22198-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <9446011.bTD6e4eDRY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 21, 2016 4:16:19 PM CEST Ben Dooks wrote:
> 
> -struct syscore_ops mvebu_mbus_syscore_ops = {
> +static struct syscore_ops mvebu_mbus_syscore_ops = {
>         .suspend        = mvebu_mbus_suspend,
>         .resume         = mvebu_mbus_resume,
>  };
> 


Looks good, but I immediately thought it should be "const" as well.
Unfortunately there is a list_head in them, so that isn't easy,
but if anyone has an idea for how to make these all const, that
would be nice.

Anyway, that shouldn't stop your patch from getting merged, so

Acked-by: Arnd Bergmann <arnd@arndb.de>

(also for patch 1/2).

	Arnd
