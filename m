From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Feb 2015 19:16:47 +0100
Subject: [RFC/PATCH 2/2] of: allow for boolean flags to have value
In-Reply-To: <1423159266-25561-2-git-send-email-balbi@ti.com>
References: <1423159266-25561-1-git-send-email-balbi@ti.com>
 <1423159266-25561-2-git-send-email-balbi@ti.com>
Message-ID: <2914350.UYQI23DbG0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 February 2015 12:01:06 Felipe Balbi wrote:
> +       /*
> +        * if property doesn't have a value, or prop->length == 0 and
> +        * we overflow, treat it as simple value-less flag.
> +        */
> +       if (rc == -ENODATA || rc == -EOVERFLOW)
> +               return true;
> +       if (WARN(rc < 0, "failed to read '%s' value -> %d\n",
> +                               propname, rc))
> +               return false;
> 

I think there are drivers today that use of_property_read_bool()
to check for the presence of a property that is not already empty.
If the property starts with a zero cell, that would break here.

	Arnd
