From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 16:24:15 +0000
Subject: [PATCH v5 03/14] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <20130108183855.46302.40539.stgit@ubuntu>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183855.46302.40539.stgit@ubuntu>
Message-ID: <20130114162415.GF23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 01:38:55PM -0500, Christoffer Dall wrote:
> +	/* -ENOENT for unknown features, -EINVAL for invalid combinations. */
> +	for (i = 0; i < sizeof(init->features)*8; i++) {
> +		if (init->features[i / 32] & (1 << (i % 32))) {

Isn't this an open-coded version of test_bit() ?
