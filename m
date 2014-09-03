From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 3 Sep 2014 13:46:13 +0100
Subject: [PATCH 2/5] efi: introduce efi_md_typeattr_format()
In-Reply-To: <1409532820-5027-3-git-send-email-lersek@redhat.com>
References: <1409532820-5027-1-git-send-email-lersek@redhat.com>
 <1409532820-5027-3-git-send-email-lersek@redhat.com>
Message-ID: <20140903124613.GD3001@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 01 Sep, at 02:53:37AM, Laszlo Ersek wrote:
> +char * __init efi_md_typeattr_format(char *buf, size_t size,
> +				     const efi_memory_desc_t *md)
> +{
> +	char *pos;
> +	int type_len;
> +	register u64 attr;

You can delete the 'register' keyword, since the compiler is free to
ignore it (and will do so).

Rest of the patch looks good.

-- 
Matt Fleming, Intel Open Source Technology Center
