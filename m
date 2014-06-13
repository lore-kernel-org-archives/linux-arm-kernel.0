From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jun 2014 10:57:14 +0100
Subject: [PATCH] i2c: sun6-p2wi: fix call to snprintf
In-Reply-To: <1402644002-2591-1-git-send-email-boris.brezillon@free-electrons.com>
References: <CAGXu5jLi5NXNsbUAn=XndDb2JSTxiVhMWbiMxtDsUOqZZhxf2A@mail.gmail.com>
 <1402644002-2591-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140613095714.GP23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 09:20:02AM +0200, Boris BREZILLON wrote:
> -	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), pdev->name);
> +	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), "%s",
> +		 pdev->name);

Isn't this just a complicated way to express:

	strlcpy(p2wi->adapter.name, pdev->name, sizeof(p2wi->adapter.name));

?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
