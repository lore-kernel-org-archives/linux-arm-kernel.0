From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 May 2015 10:27:08 +0100
Subject: Question on why specific ELF relocations are supported for
 module loader
In-Reply-To: <5F7922C2-6807-42D5-912B-418239E48331@stanford.edu>
References: <2A1C86A3-CCBE-4D59-88DF-910A2562D0E0@stanford.edu>
 <CAKv+Gu9bUJ703-CzFA3+Pnx4C9u+LWEW22Jq_6Kz3RaBkTfUyA@mail.gmail.com>
 <5F7922C2-6807-42D5-912B-418239E48331@stanford.edu>
Message-ID: <20150522092707.GE2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please wrap your message at or before column 72, so I don't have to do that
work for you in order to compose my reply.

On Fri, May 22, 2015 at 12:22:38AM -0700, Yifan Lu wrote:
> Is it even standards adherent that static relocation is used in an
> executable (rather than an object file)?

Which executable are you referring to?  The only executable is the
kernel binary itself, which is a fully-linked executable (which is
converted to a binary image.)  Modules are not executables, they
are (as Ard correctly pointed out) ELF objects.

You can't execute a module on its own: it requires to be linked to
its kernel in order to become an executable object.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
