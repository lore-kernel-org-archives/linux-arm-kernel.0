From: ndesaulniers@google.com (Nick Desaulniers)
Date: Mon, 27 Nov 2017 09:15:50 -0800
Subject: [PATCH] arm64: fix missing 'const' qualifiers
In-Reply-To: <20171125094127.7536-1-ynorov@caviumnetworks.com>
References: <20171125094127.7536-1-ynorov@caviumnetworks.com>
Message-ID: <CAKwvOdm+65Fx1gLZR3h7Vz-Ma4DNWR4W=cOL8KpKZXMgN-nCLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checked call sites, looks like no one tries to modify these pointers.
I too prefer to make things as const as possible, though I recently
had a coworker refer to the propagation of const in a code base as a
"Gordian knot," which I thought was eloquent.

checkpatch mentions that there's one line that's over 80 chars, and
that there's M$ DOS style line endings (but that may just be my client
gmail, or yours (exchange?)).  If you fix up that long line, then:

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
