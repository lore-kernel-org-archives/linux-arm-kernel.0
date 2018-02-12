From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 12 Feb 2018 21:10:10 +0100
Subject: [PATCH 1/3] dt-bindings: mfd: axp20x: Document backup battery
 charging property
In-Reply-To: <20171230152330.28946-2-contact@paulk.fr>
References: <20171230152330.28946-1-contact@paulk.fr>
 <20171230152330.28946-2-contact@paulk.fr>
Message-ID: <20180212201010.GB25608@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> This adds documentation for the "backup" property of the axp20x driver,
> that controls the charging mechanism for the backup battery on axp20x.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 9455503b0299..382776b29932 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -58,6 +58,11 @@ Optional properties:
>  	      See Documentation/devicetree/bindings/regulator/regulator.txt
>  	      for more information on standard regulator bindings.
>  
> +- backup: An array of two integers for backup battery charging (axp20x-only),
> +	  describing the charging voltage in mV first and the charging current
> +	  in uA second. Backup battery charging is only enabled when these two
> +	  fields are filled.

Well...

We do want to charge batteries other than your backup
battery. Probably this should get separate "backup battery" node with
properties explaining how it is charged?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180212/bf991805/attachment-0001.sig>
