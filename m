From: riel@redhat.com (riel at redhat.com)
Date: Fri, 19 May 2017 17:26:31 -0400
Subject: stackprotector: ascii armor the stack canary
Message-ID: <20170519212636.30440-1-riel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zero out the first byte of the stack canary value on 64 bit systems,
in order to prevent unterminated C string overflows from being able
to successfully overwrite the canary, even if an attacker somehow
guessed or obtained the canary value.

Inspired by execshield ascii-armor and PaX/grsecurity.

Thanks to Daniel Micay for extracting code of similar functionality
from PaX/grsecurity and making it easy to find in his linux-hardened
git tree on https://github.com/thestinger/linux-hardened/
