From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 27 Jul 2018 22:01:28 +0800
Subject: [PATCH 9/9] media: cedrus: Add H264 decoding support
In-Reply-To: <8c0b2fbec0302a15292d3629570ab1268fd306b8.camel@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-10-maxime.ripard@bootlin.com>
 <8c0b2fbec0302a15292d3629570ab1268fd306b8.camel@bootlin.com>
Message-ID: <CAGb2v67k_bwATPiaRVifR0gnAaG56VztpW9WifOExQbLqm2Csg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 9:56 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> Hi,
>
> On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
>> Introduce some basic H264 decoding support in cedrus. So far, only the
>> baseline profile videos have been tested, and some more advanced features
>> used in higher profiles are not even implemented.
>
> Here are two specific comments about things I noticed when going through
> the h264 code.
>
> [...]
>
>> @@ -88,12 +101,37 @@ struct sunxi_cedrus_ctx {
>>       struct work_struct run_work;
>>       struct list_head src_list;
>>       struct list_head dst_list;
>> +
>> +     union {
>> +             struct {
>> +                     void            *mv_col_buf;
>> +                     dma_addr_t      mv_col_buf_dma;
>> +                     ssize_t         mv_col_buf_size;
>> +                     void            *neighbor_info_buf;
>> +                     dma_addr_t      neighbor_info_buf_dma;
>
> Should be "neighbour" instead of "neighbor" and the same applies to most
> variables related to this, as well as the register description.

This just means you've been hanging out with people who use American
English. :)

ChenYu
