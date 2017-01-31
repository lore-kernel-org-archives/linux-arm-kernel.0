From: dhowells@redhat.com (David Howells)
Date: Tue, 31 Jan 2017 14:02:56 +0000
Subject: [PATCH 5/8] efi: Get the secure boot status [ver #6]
In-Reply-To: <20170127140101.GD31613@codeblueprint.co.uk>
References: <20170127140101.GD31613@codeblueprint.co.uk>
 <20170123212642.GA2766@codeblueprint.co.uk>
 <20170116144954.GB27351@codeblueprint.co.uk>
 <20170111143304.GA29649@codeblueprint.co.uk>
 <148120020832.5854.5448601415491330495.stgit@warthog.procyon.org.uk>
 <148120024570.5854.10638278395097394138.stgit@warthog.procyon.org.uk>
 <7948.1484148443@warthog.procyon.org.uk>
 <794.1484581158@warthog.procyon.org.uk>
 <6306.1485209503@warthog.procyon.org.uk>
Message-ID: <5842.1485871376@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt Fleming <matt@codeblueprint.co.uk> wrote:

> -  grub_memcpy (params, &lh, 2 * 512);
> +  grub_memcpy (params, (grub_uint8_t *)&lh[512], 512);

It would appear this change is wrong and params needs to be changed to params
+ 512 or something similar.

David
