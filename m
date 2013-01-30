From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 30 Jan 2013 12:55:47 +0100
Subject: kernel 3.8 make problem
Message-ID: <20130130125547.63d1cbd5@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I build the kernels in my Cubox (Marvel Dove), and it is no more
possible with kernels 3.8 while it works well with a kernel 3.5
(on the same machine - the kernels 3.5 and 3.8 have quite the
same .config).

Doing:

make oldconfig

returns:

Makefile:495: /home/jef/kernel/arch//Makefile: No such file or directory
make: *** No rule to make target `/home/jef/kernel/arch//Makefile'.  Stop.

Going further, it seems that it is because the make command 'shell'
returns nothing. A simple Makefile as:

# Makefile
var=$(shell echo toto)
$(info var:$(var))

returns:

var:
make: *** No targets.  Stop.

With strace, I get:

...
read(3, "var=$(shell echo toto)\n$(info va"..., 4096) = 43
pipe([4, 5])                            = 0
vfork()                                 = 3545
close(5)                                = 0
read(4, "", 200)                        = 0
close(4)                                = 0
wait4(-1, [{WIFSIGNALED(s) && WTERMSIG(s) == SIGSEGV}], 0, NULL) = 3545
--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x76f70000
write(1, "var:\n", 5var:
)                   = 5
...

What did I miss?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
