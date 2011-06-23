From: m.k.edwards@gmail.com (Michael K. Edwards)
Date: Thu, 23 Jun 2011 15:09:55 -0700
Subject: [Linaro-mm-sig] [PATCH/RFC 0/8] ARM: DMA-mapping framework
	redesign
In-Reply-To: <BANLkTikzTwNvaaUSk26qzONemogBAGuBRg@mail.gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<4E017539.30505@gmail.com>
	<001d01cc30a9$ebe5e460$c3b1ad20$%szyprowski@samsung.com>
	<4E01AD7B.3070806@gmail.com>
	<002701cc30be$ab296cc0$017c4640$%szyprowski@samsung.com>
	<4E02119F.4000901@codeaurora.org> <4E033AFF.4020603@gmail.com>
	<BANLkTikzTwNvaaUSk26qzONemogBAGuBRg@mail.gmail.com>
Message-ID: <BANLkTimi2FAmcb7ZWnjRqb-Cb8acXWsCTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jonathan -

I'm inviting you to this conversation (and to linaro-mm-sig, if you'd
care to participate!), because I'd really like your commentary on what
it takes to make write-combining fully effective on various ARMv7
implementations.

The current threads:
  http://lists.linaro.org/pipermail/linaro-mm-sig/2011-June/000334.html
  http://lists.linaro.org/pipermail/linaro-mm-sig/2011-June/000263.html

Archive link for a related discussion:
  http://lists.linaro.org/pipermail/linaro-mm-sig/2011-April/000003.html

Getting full write-combining performance on Intel architectures
involves a somewhat delicate dance:
  http://software.intel.com/en-us/articles/copying-accelerated-video-decode-frame-buffers/

And I expect something similar to be necessary in order to avoid the
read-modify-write penalty for write-combining buffers on ARMv7.  (NEON
store-multiple operations can fill an entire 64-byte entry in the
victim buffer in one opcode; I don't know whether this is enough to
stop the L3 memory system from reading the data before clobbering it.)

Cheers,
- Michael
