From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 15 Jun 2017 11:23:26 +0100
Subject: [PATCH 07/12] coresight replicator: Expose replicator management
 registers
In-Reply-To: <20170614175454.GC22030@xps15>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
 <1497278211-5001-8-git-send-email-suzuki.poulose@arm.com>
 <20170614175454.GC22030@xps15>
Message-ID: <79fb2dd7-c756-97aa-645f-126206bf8879@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/17 18:54, Mathieu Poirier wrote:
> On Mon, Jun 12, 2017 at 03:36:46PM +0100, Suzuki K Poulose wrote:
>> Expose the idfilter* registers of the programmable replicator.
>
> Is this for SoC600 only?  If so we need to make sure these are not visible when
> operating an SoC400 replicator.  Otherwise simply disregard my statement.

No, this is for the existing dynamic replicator, which is also compatible with the
one in SoC-600. In the future, we may be able to support multiple trace sessions
(i.e, distinct source-sink pairs using a shared dynamic replicator to filter the
data based on the trace-id). Right now we simple switch off the other side of the
replicator, when we enable the port connected to the sink.

I found these useful while debugging trace generation issue on one of the
platforms.

Suzuki
