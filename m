From: sowmini.varadhan@oracle.com (Sowmini Varadhan)
Date: Wed, 11 Mar 2015 17:50:38 -0400
Subject: [PATCH v2] rds: avoid potential stack overflow
In-Reply-To: <4321699.nNdBmxDHpu@wuerfel>
References: <4321699.nNdBmxDHpu@wuerfel>
Message-ID: <20150311215038.GA13663@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (03/11/15 22:46), Arnd Bergmann wrote:
> 
> The rds_iw_update_cm_id function stores a large 'struct rds_sock' object
> on the stack in order to pass a pair of addresses. This happens to just
> fit withint the 1024 byte stack size warning limit on x86, but just
> exceed that limit on ARM, which gives us this warning:
  :
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

--Sowmini
