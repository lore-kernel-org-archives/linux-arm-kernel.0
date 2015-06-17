From: sandyinchina@gmail.com (Sandy Harris)
Date: Wed, 17 Jun 2015 14:07:48 -0400
Subject: [PATCH v5 06/14] crypto: marvell/CESA: add DES support
In-Reply-To: <1434448748-10828-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1434448748-10828-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434448748-10828-7-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CACXcFmmBoePgVRWkrvc_JcMDOcq8ecqUuUntkBH6BWKYe0R3Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 5:59 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:

> Add support for DES operations.

Why on Earth should we do that? DES is demonstrably insecure. The only
possible excuse for allowing it anywhere in a modern code base is that
you need it to implement triple DES, and even that should by now be
deprecated in favour of more modern ciphers which are much faster and
thought to be  more secure.

Here's documentation from around the turn of the century
http://www.freeswan.org/freeswan_trees/freeswan-1.5/doc/DES.html

Moore's Law applies, so the $200,000 FPGA machine that broke DES in
days in 1998 might be dirt cheap today. Certainly breaking DES on one
of today's clusters would be fast and cheap as well, given that it
took only a few months in 1998 using the Internet as the Conectio
fabric.
http://www.interhack.net/pubs/des-key-crack/
